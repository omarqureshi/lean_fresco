describe 'Checkout' do

  it 'should collect multiple items and return the total cost' do
    Checkout.new {
      Item.new("bananas")
      Item.new("apples")
    }.should == 250
  end

end
