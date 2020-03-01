# frozen_string_literal: true

Rails.application.routes.draw do
  mount MissionKontrolRelay::Engine => '/mission_kontrol_relay'
end
