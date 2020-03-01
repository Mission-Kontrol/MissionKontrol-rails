# frozen_string_literal: true

module MissionKontrolRelay
  class ValidationMappingService
    def initialize(model)
      @model = model
    end

    def build
      {
        model: @model.name,
        validations: model_validations
      }
    end

    private

    def model_validations
      validations = []

      @model._validate_callbacks.to_a.each do |validation|
        validations << validation_attributes(validation)
      end

      validations
    end

    def validation_attributes(validation)
      {
        key: remove_klass_from_key(validation),
        type: validation.instance_variable_get(:@key).try(:kind),
        kind: validation.kind,
        name: validation.name,
        attributes: validation.try(:filter).try(:attributes),
        if: validation.instance_variable_get(:@if),
        unless: validation.instance_variable_get(:@unless)
      }
    end

    def remove_klass_from_key(validation)
      key = validation.instance_variable_get(:@key)
      if key.instance_variable_get(:@klass)
        key.instance_variable_set(:@klass, nil)
      end

      key
    end
  end
end
