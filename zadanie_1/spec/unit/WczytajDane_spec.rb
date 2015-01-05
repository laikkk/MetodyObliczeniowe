require '../../lib/WczytajDane.rb'

describe WczytajDane do
  describe '#new' do
    context 'be initialized with valid' do
      it 'without arguments' do
        expect { WczytajDane.new }.to_not raise_error
      end
  
      it 'without arguments' do
          expect(WczytajDane.new.ygreks).is_a? Array
      end

      it 'ygreks equal [1, 3, 4, 2]' do
          expect(WczytajDane.new.ygreks).to eq([1, 3, 4, 2])
      end

      it 'x0 equal 1.0' do
          expect(WczytajDane.new.x0).to eq(1.0)
      end
      
      it 'a equal 1.0' do
          expect(WczytajDane.new.a).to eq(1.0)
      end
      
      it 'b equal 2.0' do
        expect(WczytajDane.new.b).to eq(2.0)
      end

      it 'print ! - Zostana uzyte domyslne wartosci! - !' do
        dane = WczytajDane.new
        output = capture_stdout { dane.Wczytaj }
        expect(output).to include '! - Zostana uzyte domyslne wartosci! - !'
      end
    end
  end
end

describe String do  
  describe '#is_f' do
    context 'check for valid values' do
      it 'true for 123.3' do
        expect("123.3".is_f?).to be(true) 
      end

      it 'true for 1' do
        expect("1".is_f?).to be(true) 
      end

      it 'true for 111' do
        expect("111".is_f?).to be(true) 
      end

      it 'true for 0.0' do
        expect("0.0".is_f?).to be(true) 
      end

      it 'true for 0' do
        expect("0".is_f?).to be(true) 
      end

      it 'true for -0' do
        expect("-0".is_f?).to be(true) 
      end

      it 'true for -0.1234567890' do
        expect("-0.1234567890".is_f?).to be(true) 
      end

      it 'true for 0.1234567890' do
        expect("0.1234567890".is_f?).to be(true) 
      end

      it 'true for 1234567890.1234567890' do
        expect("1234567890.1234567890".is_f?).to be(true) 
      end

      it 'true for -1234567890.1234567890' do
        expect("-1234567890.1234567890".is_f?).to be(true) 
      end

      it 'true for 1234567890.1234567890' do
        expect("1234567890.1234567890".is_f?).to be(true) 
      end

      it 'true for -1234567890.1234567890' do
        expect("-1234567890.1234567890".is_f?).to be(true) 
      end
    end 
    
    context 'check for INvalid values' do
      it 'false for 123.3f' do
        expect("123.3f".is_f?).to be(false) 
      end
     
      it 'false for f123.3' do
        expect("f123.3".is_f?).to be(false) 
      end
     
      it 'false for 12f3.3' do
        expect("12f3.3".is_f?).to be(false) 
      end

      it 'false for 123f3' do
        expect("123f3".is_f?).to be(false) 
      end

      it 'false for abc' do
        expect("abc".is_f?).to be(false) 
      end

      it 'false for Abc' do
        expect("Abc".is_f?).to be(false) 
      end

      it 'false for Abc1234' do
        expect("Abc1234".is_f?).to be(false) 
      end

      it 'false for 1234Abc1234' do
        expect("1234Abc1234".is_f?).to be(false) 
      end

      it 'false for 1234Abc' do
        expect("1234Abc".is_f?).to be(false) 
      end

      it 'false for 1234A123456790' do
        expect("1234A123456790".is_f?).to be(false) 
      end
      
      it 'false for 1234A123456790.123456789v' do
        expect("1234A123456790.123456789v".is_f?).to be(false) 
      end

      it 'false for a1234A123456790.123456789v' do
        expect("a1234A123456790.123456789v".is_f?).to be(false) 
      end

      it 'false for 1234123456790.123456789v' do
        expect("1234123456790.123456789v".is_f?).to be(false) 
      end

      it 'false for a1234A123456790.123456789' do
        expect("a1234A123456790.123456789".is_f?).to be(false) 
      end

      it 'false for 1234A123456790,123456789' do
        expect("1234A123456790,123456789".is_f?).to be(false) 
      end
    end
  end
end

#helper to test outputs
def capture_stdout(&block)
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end