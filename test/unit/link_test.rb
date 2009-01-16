require File.dirname(__FILE__) + '/../test_helper'

class LinkTest < ActiveSupport::TestCase
  fixtures :categories, :links
  
  def setup
    @link = Link.create(:url => 'http://buildingwebapps.com/', :title => 'Building Web Apps',
                        :description => 'Resource for Web Developers')
    @category = Category.create(:title => 'Programming', :description => 'All of the programming resources')
  end
  
  def test_valid_model
    assert_valid @link
  end
  
  def test_valid_from_fixture
    assert_valid links(:learningrails)
  end
  
  def test_has_categories
    link = links(:learningrails)
    assert_valid link
    assert !link.categories.nil?
    assert_equal 2, link.categories.length
  end
  
  def test_add_category
    assert_valid @link
    assert_valid @category
    assert @link.categories.empty?
    assert @category.links.empty?
    assert_difference "@link.categories.length" do
      @link.categories << @category
    end
    @link.reload
    @category.reload
    assert !@link.categories.empty?
    assert !@category.links.empty?
    assert_equal 1, @link.categories.length
    assert_equal 1, @category.links.length
  end
end
