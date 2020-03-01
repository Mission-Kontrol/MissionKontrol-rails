# frozen_string_literal: true

MissionKontrolRelay::Engine.routes.draw do
  get '/' => 'application#index'
end
