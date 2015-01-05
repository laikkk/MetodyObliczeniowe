# require '../../lib/Rownanie.rb'
require_relative '../spec_helper'


describe Rownanie do
  describe '.ToString' do
    it 'give proper string' do
      rownanie = Rownanie.new
      rownanie.PrawaStrona = 10
      rownanie.LewaStrona = Wielomian.new('x', 5)
      expect(rownanie.ToString).to eq 'P(x) = a0*x^0 + a1*x^1 + a2*x^2 + a3*x^3 + a4*x^4 = 10'
    end

    it 'raise error when LewaStrona has 0 nodes' do
      expect { Wielomian.new('P(x)', 0).ToString }.to raise_error
    end
  end

  describe '.Wylicz' do
    it 'take first node and try count it value' do
      rownanie = Rownanie.new
      rownanie.PrawaStrona = 10
      rownanie.LewaStrona = Wielomian.new('x', 5)
      expect(rownanie.Wylicz).to eq({ 'a0' => 10.0 })
    end

    it 'take first node and try count it value' do
      rownanie = Rownanie.new
      rownanie.PrawaStrona = 0
      rownanie.LewaStrona = Wielomian.new('x', 5)
      expect(rownanie.Wylicz).to eq({ 'a0' => 0.0 })
    end

    it 'take first node and try count it value' do
      rownanie = Rownanie.new
      rownanie.PrawaStrona = 0
      wielomian = Wielomian.new('x', 4)
      wielomian.PodstawAn({ 'a0' => 1, 'a1' => 2, 'a2' => 3, 'a3' => 4 })
      rownanie.LewaStrona = wielomian
      expect(rownanie.Wylicz).to eq({ 1 => 0.0 })
    end
  end

  describe '.UtworzUkladRownan' do
    it 'return UkladRownan' do
      rownanie = Rownanie.new
      ygreks = [1, 2]
      wielomian = Wielomian.new('x', 2)
      uklad_rownan = rownanie.UtworzUkladRownan(ygreks, wielomian)
      expect(uklad_rownan[0].ToString).to eq 'P(x) = a0*x^0 + a1*x^1 = 1'
      expect(uklad_rownan[1].ToString).to eq 'P(x) = a1*x^0 = 2'
    end

    it 'return UkladRownan.length == passed ygreks.length' do
      rownanie = Rownanie.new
      ygreks = [1, 2]
      wielomian = Wielomian.new('x', 5)
      expect(rownanie.UtworzUkladRownan(ygreks, wielomian).length).to eql ygreks.length
    end
  end

  describe '.RozwiazUkladRownan' do
    it 'return vaild hash when pass valid params' do
      rownanie = Rownanie.new
      ygreks = [1, 2]
      wielomian = Wielomian.new('x', 2)
      uklad_rownan = rownanie.UtworzUkladRownan(ygreks, wielomian)
      rozwiazany_uklad_rownan = rownanie.RozwiazUkladRownan(uklad_rownan)
      expect(rozwiazany_uklad_rownan).to eq({ 'a1' => 2.0, 'a0' => 1.0 })
    end

    it 'return hash.length == like passed uklad_rownan.length' do
      rownanie = Rownanie.new
      ygreks = [1, 2]
      wielomian = Wielomian.new('x', 2)
      uklad_rownan = rownanie.UtworzUkladRownan(ygreks, wielomian)
      rozwiazany_uklad_rownan = rownanie.RozwiazUkladRownan(uklad_rownan)
      expect(rozwiazany_uklad_rownan.length).to eql uklad_rownan.length
    end
  end
end
