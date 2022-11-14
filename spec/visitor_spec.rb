require './lib/visitor'

RSpec.describe Visitor do
  let!(:visitor1) {Visitor.new('Bruce', 54, '$10')}
  
  it 'creates as a Visitor class with attributes' do
    expect(visitor1).to be_an_instance_of Visitor
    expect(visitor1.name).to eq 'Bruce'
    expect(visitor1.height).to eq 54
    expect(visitor1.spending_money).to eq 10
    expect(visitor1.preferences).to eq []
  end
  
  it 'can add preferences' do
    expect(visitor1.preferences).to eq []
    visitor1.add_preference(:gentle)
    expect(visitor1.preferences).to eq [:gentle]
    visitor1.add_preference(:water)
    expect(visitor1.preferences).to eq [:gentle, :water]
  end
  
  it 'returns true or false when asked if they are tall enough' do
    visitor2 = Visitor.new('Tucker', 36, '$5')
    visitor3 = Visitor.new('Penny', 64, '$15')
    expect(visitor1.tall_enough?(54)).to be true
    expect(visitor2.tall_enough?(54)).to be false
    expect(visitor3.tall_enough?(54)).to be true
    expect(visitor1.tall_enough?(64)).to be false
  end
  
end