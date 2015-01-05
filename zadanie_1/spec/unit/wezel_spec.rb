# require '../../lib/Wezel.rb'
require_relative '../spec_helper'


describe Wezel do

  subject(:wezelya50) { Wezel.new(10, 'y', 'a', 5.0) }
  subject(:wezelXa50) { Wezel.new(10, 'X', 'a', 5.0) }

  describe '#new' do
    context 'be initialized with valid' do
      it 'one arguments' do
        expect { Wezel.new(10) }.to_not raise_error
      end

      it 'two arguments' do
        expect { Wezel.new(10, 'y') }.to_not raise_error
      end

      it 'three arguments' do
        expect { Wezel.new(10, 'y', 'a') }.to_not raise_error
      end

      it 'four arguments' do
        expect { wezelya50 }.to_not raise_error
      end
    end

    context 'raise error when initialize with INvalid' do
      it 'one of one arguments' do
        expect { Wezel.new('Foo') }.to raise_error
      end

      it 'one of two arguments' do
        expect { Wezel.new('Foo', 'Y') }.to raise_error
      end

      it 'one of two arguments' do
        expect { Wezel.new('Y', 10) }.to raise_error
      end

      it 'two arguments' do
        expect { Wezel.new('10', 10) }.to raise_error
      end

      it 'wspolczynnik [int]' do
        expect { Wezel.new(10, 'y', 10) }.to raise_error
      end

      it 'wspPom [string]' do
        expect {  Wezel.new(10, 'y', 'a', '5') }.to raise_error
      end
    end
  end

  describe '#WspolczynnikPomocniczy' do
    it 'be this same as initialized' do
      expect(wezelya50.WspolczynnikPomocniczy).to eq(5.0)
    end
    it 'be a number' do
      expect(wezelya50.WspolczynnikPomocniczy).to be_a Float
    end
  end

  describe '#Potega' do
    it 'be this same as initialized' do
      expect(wezelya50.Potega).to eq 10
    end
    it 'be a number' do
      expect(wezelya50.Potega).to be_a Fixnum
    end
  end

  describe '#X' do
    it 'be this same as initialized' do
      expect(wezelXa50.X).to eq 'X'
    end
    it 'be this same as initialized (default param)' do
      expect(Wezel.new(10).X).to eq 'x'
    end
    it 'be a string' do
      expect(wezelXa50.X).to be_a String
    end
  end

  describe '#Wspolczynnik' do
    it 'be this same as initialized' do
      expect(wezelXa50.Wspolczynnik).to eq 'a'
    end
    it 'be this same as initialized (default param)' do
      expect(Wezel.new(10).Wspolczynnik).to eq 'a10'
    end
    it 'be a string' do
      expect(wezelXa50.Wspolczynnik).to be_a String
    end
  end

  describe '#ToString' do
    it 'give string as given parameters' do
      expect(wezelXa50.ToString).to eq 'a*5.0*X^10'
    end

    it 'give string as given parameters' do
      expect(Wezel.new(10).ToString).to eq 'a10*x^10'
    end

    it 'give string as given parameters' do
      expect(Wezel.new(10, 'y').ToString).to eq 'a10*y^10'
    end

    it 'give string as given parameters' do
      expect(Wezel.new(10, 'y', 'a').ToString).to eq 'a*y^10'
    end
  end
end
