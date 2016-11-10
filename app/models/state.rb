class State
  def self.find(state = nil)
    return unless state
    state.upcase.tap do |normalized_state|
      raise RecordNotFound, 'State not found' unless all.include?(normalized_state)
    end
  end

  def self.all
    %w(AC AL AM AP
       BA CE DF ES GO
       MA MG MS MT
       PA PB PE PI PR
       RJ RN RO RR RS
       SC SE SP
       TO)
  end
end
