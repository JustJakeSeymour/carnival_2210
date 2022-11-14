require './lib/visitor'
require './lib/ride'
require './lib/carnival'

RSpec.describe Carnival do
  let!(:carnival) {Carnival.new(['2022/10/28', '2022/10/31'])}
  let!(:ride1) {Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })}
  let!(:visitor1) {Visitor.new('Bruce', 54, '$10')}
  let!(:visitor2) {Visitor.new('Tucker', 36, '$5')}
  let!(:visitor3) {Visitor.new('Penny', 64, '$15')}
  let!(:ride2) {Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })}
  let!(:ride3) {Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })}

  it 'starts as a Carnival class and a duration' do
    expect(carnival).to be_an_instance_of Carnival
    expect(carnival.duration).to be 3
    expect(carnival.rides).to eq []
  end
  
  it 'adds rides' do
    expect(carnival.rides).to eq []
    carnival.add_ride(ride1)
    expect(carnival.rides).to eq [ride1]
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)
    expect(carnival.rides).to eq [ride1, ride2, ride3]
  end
  
  it 'knows the most popular ride' do
    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)
    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)
    visitor2.add_preference(:thrilling)
    visitor3.add_preference(:thrilling)
    
    3.times{ride1.board_rider(visitor2)}
    2.times{ride2.board_rider(visitor1)}
    2.times{ride3.board_rider(visitor3)}
    
    expect(carnival.most_popular_ride).to eq ride1
  end
  
  it 'knows the most profitable ride' do
    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)
    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)
    visitor2.add_preference(:thrilling)
    visitor3.add_preference(:thrilling)
    
    3.times{ride1.board_rider(visitor2)}
    2.times{ride2.board_rider(visitor1)}
    2.times{ride3.board_rider(visitor3)}
    
    expect(carnival.most_profitable_ride).to eq ride2
  end
  
  it 'knows total revenue from all rides' do
    carnival.add_ride(ride1)
    carnival.add_ride(ride2)
    carnival.add_ride(ride3)
    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)
    visitor2.add_preference(:thrilling)
    visitor3.add_preference(:thrilling)
    
    ride1.board_rider(visitor2)
    ride2.board_rider(visitor1)
    ride3.board_rider(visitor3)
   
    expect(carnival.total_revenue).to eq 8
  end
  
end