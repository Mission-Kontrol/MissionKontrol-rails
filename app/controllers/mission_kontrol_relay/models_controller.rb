# frozen_string_literal: true

module MissionKontrolRelay
  class ModelsController < ApplicationController
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
