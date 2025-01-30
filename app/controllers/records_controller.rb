require "net/http"
require "uri"

class RecordsController < ApplicationController
  def index
    @records = Record.all.order(created_at: :desc)
  end

  def create
    @record = Record.new(record_params)

    if @record.save
      respond_to do |format|
        format.html { redirect_to records_path }
        format.turbo_stream
      end
    else
      render :new
    end
  end

  def new
    @record = Record.new
  end

  def show
    @record = Record.find(params[:id])
  end

  def edit
    @record = Record.find(params[:id])
  end

  def update
    @record = Record.find(params[:id])
    @record.update(record_params)
    redirect_to records_path
  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy
    respond_to do |format|
      format.html { redirect_to records_path }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@record) }
    end
  end

  def search
    return if params[:query].blank?

    @records = Record.joins(:artist)
                  .where("LOWER(records.title) LIKE :query OR LOWER(artists.name) LIKE :query",
                    query: "%#{params[:query].downcase}%").limit(6)
  end

  def discogs_search
  end

  def discogs_results
    uri = URI("https://api.discogs.com/database/search")
    uri.query = URI.encode_www_form({
      q: params[:query],
      type: "release"
    })

    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Discogs token=#{ENV['DISCOGS_TOKEN']}"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    @results = JSON.parse(response.body)["results"]
  end

  def discogs_import
    uri = URI("https://api.discogs.com/releases/#{params[:id]}")

    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Discogs token=#{ENV['DISCOGS_TOKEN']}"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    @discogs_record = JSON.parse(response.body)

    @record = Record.find_by(discogs_id: @discogs_record["id"])

    if @record.nil?

    @artist = Artist.find_by(discogs_id: @discogs_record["artists"][0]["id"])
    if @artist.nil?
      uri = URI("https://api.discogs.com/artists/#{@discogs_record["artists"][0]["id"]}")
      request = Net::HTTP::Get.new(uri)
      request["Authorization"] = "Discogs token=#{ENV['DISCOGS_TOKEN']}"
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end
      @discogs_artist = JSON.parse(response.body)
      @artist = Artist.create(name: @discogs_artist["name"], discogs_id: @discogs_artist["id"])

      if @discogs_artist["images"].present? && @discogs_artist["images"][0].present?
        avatar_uri = URI(@discogs_artist["images"][0]["uri"])
        avatar_response = Net::HTTP.get_response(avatar_uri)
        avatar_file = StringIO.new(avatar_response.body)

        @artist.avatar.attach(io: avatar_file, filename: "avatar.jpg")
      end

      @artist.save
    end

    @running_time = @discogs_record["tracklist"].map do |track|
      if track["duration"].present?
        minutes, seconds = track["duration"].split(":").map(&:to_i)
        minutes * 60 + seconds
      else
        0
      end
    end.sum

    @record = Record.new(
      title: @discogs_record["title"],
      discogs_id: @discogs_record["id"],
      running_time: @running_time,
      artist_id: @artist.id,
    )

    cover_uri = URI(@discogs_record["images"][0]["resource_url"])
    cover_response = Net::HTTP.get_response(cover_uri)
    cover_file = StringIO.new(cover_response.body)
    @record.cover.attach(io: cover_file, filename: "cover.jpg")
    @record.save

    respond_to do |format|
      format.html { redirect_to records_path }
      format.turbo_stream
    end
    end
  end


  private

  def record_params
    params.require(:record).permit(:title, :artist_id, :cover, :running_time)
  end
end
