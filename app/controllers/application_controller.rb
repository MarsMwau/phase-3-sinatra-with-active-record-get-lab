class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  # add routes
  get '/bakeries' do
    # get all the bakeries from the database
    bakeries = Bakery.all
    # return a JSON response with an array of all the bakery data
    bakeries.to_json
  end

  get '/bakeries/:id' do
    # look up the bakery in the database using its ID
    bakery = Bakery.find(params[:id])
    # send a JSON-formatted response of the bakery data
    bakery.to_json(include: :baked_goods)
  end

  get '/baked_goods/by_price' do
    # get the baked goods from the database
      baked_goods = BakedGood.all.order(price: :desc)
    # return a JSON response with an array of all the baked goods data
      baked_goods.to_json(only: [:id, :name, :price, :bakery_id])
  end

  get '/baked_goods/most_expensive' do
    # get the most expensive baked good from the database
    most_expensive = BakedGood.all.order(price: :desc).first
    # return a JSON response with the baked good data
    most_expensive.to_json(only: [:id, :name, :price, :bakery_id])
  end

end
