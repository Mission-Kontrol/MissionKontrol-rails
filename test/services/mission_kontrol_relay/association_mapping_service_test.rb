module MissionKontrolRelay
  class AssociationMappingServiceTest < ActiveSupport::TestCase
    def setup
      @association_mapping_company = AssociationMappingService.new(Company).build
      @association_mapping_user = AssociationMappingService.new(User).build
    end

    test 'returns a hash with the model name' do
      assert_equal @association_mapping_company[:model], 'Company'
    end

    test 'returns an array of columns on the model' do
      assert_kind_of Array, @association_mapping_company[:columns]
    end

    test 'returns the name on the columns' do
      assert_equal @association_mapping_company[:columns].first[:column], "id"
    end

    test 'returns the sql type on the columns' do
      assert_equal @association_mapping_company[:columns].first[:type], :integer
    end

    test 'returns an array of associations on the model' do
      assert_kind_of Array, @association_mapping_company[:associations]
    end

    test 'returns name of related model when belongs_to relationship present' do
      assert_equal @association_mapping_company[:associations].first[:associated_model], :user
    end

    test 'returns foreign_key of related model when belongs_to relationship present' do
      assert_equal @association_mapping_company[:associations].first[:foreign_key], "owner"
    end

    test 'returns type of related model when belongs_to relationship present' do
      assert_equal @association_mapping_company[:associations].first[:type], :belongs_to
    end

    test 'returns name of related model when has_one relationship present' do
      assert_equal @association_mapping_user[:associations].first[:associated_model], :company
    end

    test 'returns type of related model when has_one relationship present' do
      assert_equal @association_mapping_user[:associations].first[:type], :has_one
    end
  end
end