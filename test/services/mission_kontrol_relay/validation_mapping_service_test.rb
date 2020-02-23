module MissionKontrolRelay
  class ValidationMappingServiceTest < ActiveSupport::TestCase
    def setup
      @validation_mapping_company = ValidationMappingService.new(Company).build
      @validation_mapping_user = ValidationMappingService.new(User).build
    end

    test 'returns a hash with the model name' do
      assert_equal 'User', @validation_mapping_user[:model]
    end

    test 'returns an array of validations on the model' do
      assert_kind_of Array, @validation_mapping_user[:validations]
    end

    test 'returns a hash with the validation information for user' do
      expected_result = {
        key: nil,
        kind: :before,
        name: :validate,
        attributes: [:name]
      }

      assert_equal expected_result, @validation_mapping_user[:validations]
    end

    test 'returns a hash with the validation information for company' do
      expected_result = {
        key: nil,
        kind: :before,
        name: :validate,
        attributes: [:owner],
        if: [:something_else?]
      }

      assert_equal expected_result, @validation_mapping_company[:validations]
    end
  end
end