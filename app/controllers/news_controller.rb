require "httparty"

class NewsController < ApplicationController
  before_action :set_news, only: [:show, :edit, :update, :destroy]
    
  # GET /news
  # GET /news.json
  # NYT-api to be moved to another controller
  def index
    key = "7a3872ec641840f6a31b6b4da77aad1d"
    search ="trees"
    startYear = '20160101'
    endYear = '20170101'
    url = 'http://api.nytimes.com/svc/search/v2/articlesearch.json?api_key='+key+'&q='+search+'&begin_date='+startYear+'&end_date='+endYear
    response = HTTParty.get(url)

    @search_param = params

    @article = response["response"]["docs"]

    @news = News.new
  end

  # GET /news/1
  # GET /news/1.json
  def shows
    @news = News.find(params[:id])
  end

  # GET /news/new
  def new
    @news = News.all
  end

  # GET /news/1/edit
  def edit
  end

  # POST /news
  # POST /news.json
  def create
    @news = News.new(news_params)
    # puts news_params

    respond_to do |format|
      if @news.save
        format.html { redirect_to news_index_url, notice: 'News was successfully created.' }
        format.json { render :show, status: :created, location: @news }
      else
        format.html { render :new }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news/1
  # PATCH/PUT /news/1.json
  def update
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to news_index_url, notice: 'News was successfully updated.' }
        format.json { render :show, status: :ok, location: @news }
      else
        format.html { render :edit }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @news.destroy
    respond_to do |format|
      format.html { redirect_to "/news/new", notice: 'News was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = News.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      params.require(:news).permit(:title, :snippet, :url)
    end
end
