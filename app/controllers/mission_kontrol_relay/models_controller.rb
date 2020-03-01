# frozen_string_literal: true

module MissionKontrolRelay
  class ModelsController < ApplicationController
    before_action :validate_token
    before_action :available_models

    def associations
      call_association_service

      render json: @associations
    end

    def validations
      call_validation_service

      render json: @model_validations
    end

    private

    def permitted_params
      params.permit(:token)
    end

    def validate_token
      token_matches = permitted_params[:token] == ENV['MISSION_KONTROL_TOKEN']
      message = if permitted_params[:token] && !token_matches
                  'Invalid token'
                elsif permitted_params[:token].nil?
                  'Please provide a token'
                end

      return if token_matches

      render json: { error: message }, status: :unauthorized
    end

    def available_models
      @available_models ||= MissionKontrolRelay::ModelRetrievalService.call
    end

    def call_association_service
      @associations = []

      @available_models.each do |model|
        association = MissionKontrolRelay::AssociationMappingService.new(model)
                                                                    .build
        @associations << association
      end
    end

    def call_validation_service
      @model_validations = []

      @available_models.each do |model|
        validation = MissionKontrolRelay::ValidationMappingService.new(model)
                                                                  .build
        @model_validations << validation
      end
    end
  end
end
