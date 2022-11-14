require './lib/ride'
require './lib/visitor'

RSpec.describe Ride do
  let!(ride1) {Ride.new({ :name 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })}
  let!(visitor1) {Visitor.new('Bruce', 54, '$10')}
  let!(visitor2) {Visitor.new('Tucker', 36, '$5')}
  let!(visitor1.add_preference(:gentle))
  let!(visitor2.add_preference(:gentle))

  it 'is created as a Ride class with attributes supplied in a single hash' do
    expect(ride1).to be_an_instance_of Ride
    expect(ride1.name).to eq 'Carousel'
    expect(ride1.min_height).to eq 24
    expect(ride1.admission_fee).to eq 1
    expect(ride1.excitement).to eq :gentle
    expect(ride1.total_revenue).to eq 0
    expect(ride1.rider_log).to eq {}
  end
  
  it 'boards riders and adds them to the rider log' do
    expect(ride1.rider_log).to eq {}
    ride1.board_rider(visitor1)
    expect(ride1.rider_log).to eq ({ visitor1: 1 })
    ride1.board_rider(visitor2)
    expect(ride1.rider_log).to eq ({ visitor1: 1, visitor2: 1 })
    ride1.board_rider(visitor1)
    expect(ride1.rider_log).to eq ({ visitor1: 2, visitor2: 1 })
  end
  
  it 'removes cost of ride from visitor for each time they ride' do
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
    expect(ride1.total_revenue).to eq 0
    
    ride1.board_rider(visitor1)
    expect(ride1.total_revenue).to eq 1
    
    ride1.board_rider(visitor2)
    expect(ride1.total_revenue).to eq 2
    
    ride1.board_rider(visitor1)
    expect(ride1.total_revenue).to eq 3
  end
end