require './car'

describe Car do
  subject { Car.new('N', 0, 0, 1) }

  describe '#faster' do
    it { expect { subject.faster }.to change { subject.speed }.by 1 }
  end

  describe '#slower' do
    it { expect { subject.slower }.to change { subject.speed }.by -1 }
  end

  describe '#left' do
    it { expect { subject.left }.to change { subject.direction }.to 'NW' }
  end

  describe '#right' do
    it { expect { subject.right }.to change { subject.direction }.to 'NE' }
  end

  describe '#move' do
    context "" do
      subject { Car.new('SE', 0, 0, 1) }
      it do
        expect { subject.move }
          .to change { subject.coords }.to Point.new(2,0)
      end
    end
    context "" do
      subject { Car.new('SE', 0, 1, 1) }
    end

  end
end