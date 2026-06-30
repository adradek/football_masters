# frozen_string_literal: true

class ApplicationCommand
  def self.call(...) = new(...).call

  def call = raise NoMethodError, "#{self.class} must implement #call"
end
