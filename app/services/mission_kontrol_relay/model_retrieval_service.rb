module MissionKontrolRelay
  class ModelRetrievalService
    class << self
      def build
        Rails.application.eager_load!
        ActiveRecord::Base.descendants.collect{ |t| t.to_s if valid_table?(t) }.compact
      end

      private

      def valid_table?(table)
        table.table_exists? && not_join_table?(table)
      end

      def not_join_table?(table)
        table.to_s.split('::').last.split('_').first != "HABTM"
      end
    end
  end
end