# frozen_string_literal: true

module MissionKontrolRelay
  class ModelRetrievalService
    class << self
      def build
        Rails.application.eager_load!
        ActiveRecord::Base.descendants.collect do |t|
          t.to_s if valid_table?(t)
        end .compact
      end

      private

      def valid_table?(table)
        table.table_exists? && not_join_table?(table)
      end

      def not_join_table?(table)
        table.to_s.split('::').last.split('_').first != 'HABTM'
      end
    end
  end
end
