# frozen_string_literal: true

MissionKontrolRelay::Engine.routes.draw do
  get '/' => 'application#index'

  resources :models, only: [] do
    get :associations, on: :collection
    get :validations, on: :collection
  end
end
