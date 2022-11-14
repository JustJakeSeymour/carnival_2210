require './lib/ride'
require './lib/visitor'

RSpec.describe Ride do
  let!(:ride1) {Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })}
  let!(:visitor1) {Visitor.new('Bruce', 54, '$10')}
  let!(:visitor2) {Visitor.new('Tucker', 36, '$5')}
  
  it 'is created as a Ride class with attributes supplied in a single hash' do
    expect(ride1).to be_an_instance_of Ride
    expect(ride1.name).to eq 'Carousel'
    expect(ride1.min_height).to eq 24
    expect(ride1.admission_fee).to eq 1
    expect(ride1.excitement).to eq :gentle
    expect(ride1.total_revenue).to eq 0
    expect(ride1.rider_log).to eq ({})
  end
  
  it 'boards riders and adds them to the rider log' do
    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)
    expect(ride1.rider_log).to eq ({})
    ride1.board_rider(visitor1)
    expect(ride1.rider_log).to eq ({ visitor1 => 1 })
    ride1.board_rider(visitor2)
    expect(ride1.rider_log).to eq ({ visitor1 => 1, visitor2 => 1 })
    ride1.board_rider(visitor1)
    expect(ride1.rider_log).to eq ({ visitor1 => 2, visitor2 => 1 })
  end
  
  it 'removes cost of ride from visitor for each time they ride' do
    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)
    expect(visitor1.spending_money).to eq 10
    expect(visitor2.spending_money).to eq 5
    
    ride1.board_rider(visitor1)
    ride1.board_rider(visitor2)
    
    expect(visitor1.spending_money).to eq 9
    expect(visitor2.spending_money).to eq 4
    
    ride1.board_rider(visitor1)
    
    expect(visitor1.spending_money).to eq 8
  end
  
  it 'knows the revenue based on amount of rides taken' do
    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)
    expect(ride1.total_revenue).to eq 0
    
    ride1.board_rider(visitor1)
    expect(ride1.total_revenue).to eq 1
    
    ride1.board_rider(visitor2)
    expect(ride1.total_revenue).to eq 2
    
    ride1.board_rider(visitor1)
    expect(ride1.total_revenue).to eq 3
  end
  
  it 'does not let visitors ride if they do not reach the minimum height or do not like the excitement level' do
    visitor3 = Visitor.new('Penny', 64, '$15')
    ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
    
    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)
    visitor2.add_preference(:thrilling)
    visitor3.add_preference(:thrilling)
    
    expect(visitor1.spending_money).to eq 10
    expect(visitor2.spending_money).to eq 5
    expect(visitor3.spending_money).to eq 15
    
    ride3.board_rider(visitor1)
    ride3.board_rider(visitor2)
    ride3.board_rider(visitor3)
    
    expect(visitor1.spending_money).to eq 10
    expect(visitor2.spending_money).to eq 5
    # expect(visitor3.spending_money).to eq 13
    
    expect(ride3.rider_log).to eq ({ visitor3 => 1 })
    expect(ride3.total_revenue).to eq 2
  end


  
end