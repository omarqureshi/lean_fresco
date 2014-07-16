describe 'Item' do

  it 'should give me 100 for apples' do
    Item.new("apples").should == 100
  end

  it 'should give me 150 for bananas' do
    Item.new("bananas").should == 150
  end

  it 'should give me 100 for cherries' do
    Item.new("cherries").should == 75
  end

end
