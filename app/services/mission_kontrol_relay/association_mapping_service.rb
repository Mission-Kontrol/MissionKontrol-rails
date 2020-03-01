# frozen_string_literal: true

module MissionKontrolRelay
  class AssociationMappingService
    def initialize(model)
      @model = model
    end

    def build
      {
        model: @model.name,
        columns: model_columns,
        associations: model_associations
      }
    end

    private

    def model_columns
      columns = []

      @model.columns.each do |column|
        columns << {
          column: column.name,
          type: column.sql_type_metadata.type
        }
      end

      columns
    end

    def model_associations
      associations = []

      @model.reflections.each do |association|
        association = association.last
        associations << {
          associated_model: association.name,
          type: association.macro,
          options: association.try(:options)
        }
      end

      associations
    end
  end
end
