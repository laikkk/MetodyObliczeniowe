# require '../../lib/Wielomian.rb'
require_relative '../spec_helper'

describe Wielomian do

  subject(:wielomianPodX5) { Wielomian.new('P(x)', 5) }
  subject(:wezelXa50) { Wezel.new(10, 'X', 'a', 5.0) }
let(:wezel0Px101) { instance_double('Wezel', Potega: 0, X: 'P(x)', WspolczynnikPomocniczy: 1.0, WartoscWezla: 0, Wspolczynnik: 'a0') }
let(:wezel1Px101) { instance_double('Wezel', Potega: 1, X: 'P(x)', WspolczynnikPomocniczy: 1.0, WartoscWezla: 0, Wspolczynnik: 'a1') }
let(:wezel2Px102) { instance_double('Wezel', Potega: 2, X: 'P(x)', WspolczynnikPomocniczy: 1.0, WartoscWezla: 0, Wspolczynnik: 'a2') }
let(:wezel3Px103) { instance_double('Wezel', Potega: 3, X: 'P(x)', WspolczynnikPomocniczy: 1.0, WartoscWezla: 0, Wspolczynnik: 'a3') }
let(:wezel4Px104) { instance_double('Wezel', Potega: 4, X: 'P(x)', WspolczynnikPomocniczy: 1.0, WartoscWezla: 0, Wspolczynnik: 'a4') }
let(:rownaniewielomianu) { [wezel0Px101, wezel1Px101, wezel2Px102, wezel3Px103, wezel4Px104] }

  describe '#new' do
    it 'be initialized with appropriate params' do
      expect { Wielomian.new('P(x)', 5) }.to_not raise_error
    end

    it 'be initialized with appropriate params' do
      expect { Wielomian.new('P(x)', 0) }.to_not raise_error
    end

    it 'be initialized with appropriate params' do
      expect { Wielomian.new('P(x)', 100) }.to_not raise_error
    end
  end

  describe '#PodX' do
    it 'be this same as passed to constructor' do
      expect(Wielomian.new('P(x)', 5).PodX).to eq 'P(x)'
    end

    it 'be string' do
      expect(Wielomian.new('P(x)', 5).PodX).to be_a String
    end
  end

  describe '#RownanieWielomianu' do
    it '.length be this as passed' do
      expect(Wielomian.new('P(x)', 5).RownanieWielomianu.length).to eq 5
    end

    it '.length be this as passed' do
      expect(Wielomian.new('P(x)', 0).RownanieWielomianu.length).to eq 0
    end

    it '.contains appropriate Wezel''s' do
      wielomian = Wielomian.new('P(x)', 3)
      expect(wielomian.RownanieWielomianu[0].Potega).to eq wezel0Px101.Potega
      expect(wielomian.RownanieWielomianu[0].Wspolczynnik).to eq wezel0Px101.Wspolczynnik
      expect(wielomian.RownanieWielomianu[0].WspolczynnikPomocniczy).to eq wezel0Px101.WspolczynnikPomocniczy
      expect(wielomian.RownanieWielomianu[0].X).to eq wezel0Px101.X
      expect(wielomian.RownanieWielomianu[0].WartoscWezla).to eq wezel0Px101.WartoscWezla
    end
  end

  describe '#CalkowanyWielominan' do
    it '.be null after Wielomian initialize' do
      expect(Wielomian.new('P(x)', 5).CalkowanyWielominan).to eql nil
    end
  end

  describe '.PostacOgolna' do
    it 'has this same count of nodes as before call' do
      x = Wielomian.new('P(x)', 5)
      x.PostacOgolna
      expect(x.RownanieWielomianu.length).to eq 5
    end

    it 'PodX should be equal "x"' do
      x = Wielomian.new('P(x)', 0)
      x.PostacOgolna
      expect(x.PodX).to eq 'x'
    end

    it 'after call, ToString should return Wielomian in PostacOgolna [P(x) = a0*x^0 + a1*x^1 + a2*x^2]' do
      wielomian = Wielomian.new('P(x)', 3)
      wielomian.PostacOgolna
      expect(wielomian.ToString).to eq 'P(x) = a0*x^0 + a1*x^1 + a2*x^2'
    end

    it 'after call each node should contains "x"' do
      wielomian = Wielomian.new('P(x)', 3)
      wielomian.PostacOgolna
      expect(wielomian.RownanieWielomianu[0].X).to eq 'x'
      expect(wielomian.RownanieWielomianu[1].X).to eq 'x'
      expect(wielomian.RownanieWielomianu[2].X).to eq 'x'
    end

    it 'after call PodX should be eq x' do
      wielomian = Wielomian.new('P(x)', 3)
      wielomian.PostacOgolna
      expect(wielomian.PodX).to eq 'x'
    end

  end

  describe '.ToString' do
    it 'contains given Nodes(5)' do
      expect(Wielomian.new('P(x)', 5).ToString).to eq 'P(P(x)) = a0*P(x)^0 + a1*P(x)^1 + a2*P(x)^2 + a3*P(x)^3 + a4*P(x)^4'
    end

    it 'contains given Nodes(0)' do
      expect { Wielomian.new('P(x)', 0).ToString }.to raise_error
    end
  end

  describe '.PodstawAn' do
    ans = { 'a0' => 1, 'a1' => 2, 'a2' => 3, 'a3' => 4, 'a4' => 5 }
    it 'after fill with valid ans each Wspolczynnik should fit' do
      wielomian = Wielomian.new('P(x)', 5)
      wielomian.PodstawAn(ans)
      expect(wielomian.RownanieWielomianu[0].Wspolczynnik).to eql ans.values[0]
      expect(wielomian.RownanieWielomianu[1].Wspolczynnik).to eql ans.values[1]
      expect(wielomian.RownanieWielomianu[2].Wspolczynnik).to eql ans.values[2]
      expect(wielomian.RownanieWielomianu[3].Wspolczynnik).to eql ans.values[3]
      expect(wielomian.RownanieWielomianu[4].Wspolczynnik).to eql ans.values[4]
    end

    it 'after fill with empty hash each Wspolczynnik should be eql a0, a1 etc' do
      wielomian = Wielomian.new('P(x)', 5)
      wielomian.PodstawAn({})
      expect(wielomian.RownanieWielomianu[0].Wspolczynnik).to eql 'a0'
      expect(wielomian.RownanieWielomianu[1].Wspolczynnik).to eql 'a1'
      expect(wielomian.RownanieWielomianu[2].Wspolczynnik).to eql 'a2'
      expect(wielomian.RownanieWielomianu[3].Wspolczynnik).to eql 'a3'
      expect(wielomian.RownanieWielomianu[4].Wspolczynnik).to eql 'a4'
    end

    it 'dont raise error when passing empty hash' do
      expect { Wielomian.new('P(x)', 3).PodstawAn({}) }.to_not raise_error
    end
  end

  describe '.WyliczGdzieSieDa [it count WartoscWezla]' do
    it 'in default Wielomain should return this same RownanieWielomianu' do
      wielomian = Wielomian.new('P(x)', 2)
      wielomian.PodstawAn({ 'a0' => 1, 'a1' => 2 })
      wielomian.WyliczGdzieSieDa()
      expect(wielomian.RownanieWielomianu[0].WartoscWezla).to eql(1.0)
      expect(wielomian.RownanieWielomianu[1].WartoscWezla).to eql(0.0)
    end

    it 'after initialize but not .PodstawAn should WartoscWezla be 0' do
      wielomian = Wielomian.new('P(x)', 2)
      wielomian.WyliczGdzieSieDa()
      expect(wielomian.RownanieWielomianu[0].WartoscWezla).to eql(0)
      expect(wielomian.RownanieWielomianu[1].WartoscWezla).to eql(0)
    end

    it 'after initialize should WartoscWezla be 0' do
      wielomian = Wielomian.new('P(x)', 2)
      expect(wielomian.RownanieWielomianu[0].WartoscWezla).to eql(0)
      expect(wielomian.RownanieWielomianu[1].WartoscWezla).to eql(0)
    end
  end

  describe '.PoliczCalke' do
    wielomian = Wielomian.new('P(x)', 5)
    wielomian.PodstawAn({ 'a0' => 1, 'a1' => 2, 'a2' => 3, 'a3' => 4, 'a4' => 5 })
    wielomian.WyznaczCalke
    it 'count Calke (1, 2) after .PodstawAn() with vaild values and after .WyznaczCalke()' do
      expect(wielomian.PoliczCalke(1, 2)).to eq 57.0
    end

    it 'raise error when nodes arent counted' do
      expect { Wielomian.new('P(x)', 5).PoliczCalke(0, 2) }.to raise_error
    end
  end

  describe '.WyznaczCalke' do
    wielomian = Wielomian.new('P(x)', 5)
    wielomian.WyznaczCalke

    it 'CalkowanyWielominan be initialize after call' do
      expect(wielomian.CalkowanyWielominan).to_not eql nil
    end

    it 'CalkowanyWielominan has length as RownanieWielomianu' do
      wielomian.WyznaczCalke
      expect(wielomian.CalkowanyWielominan.length).to eql wielomian.RownanieWielomianu.length
    end
  end

  describe '.An' do
    it 'give first Wspolczynnik' do
      expect(Wielomian.new('P(x)', 5).An).to eq 'a0'
    end

    it 'raise error when iloscWspolczynnikow is eq 0' do
      expect { Wielomian.new('P(x)', 0).An }.to raise_error
    end
  end

  describe '.ToCoStoiPrzyA' do
    it 'defualt value near a0 is 1' do
      expect(Wielomian.new('P(x)', 5).ToCoStoiPrzyA).to eq 1.0
    end

    it 'raise error when iloscWspolczynnikow is eq 0' do
      expect { Wielomian.new('P(x)', 0).ToCoStoiPrzyA }.to raise_error NoMethodError
    end
  end
end
