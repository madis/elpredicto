class ConversionsController < ApplicationController
  def new
    render locals: {
      errors: conversion_form.errors,
      conversion: conversion_form.to_h,
      currencies: ConversionForm::CURRENCIES,
      wait_times: ConversionForm::WAIT_TIMES,
      predictions: predictions
    }
  end

  private

  def predictions
    return if conversion_form.errors.present?

    predictor.predict(
      amount: conversion_form[:amount],
      max_wait: conversion_form[:max_wait]
    )
  end

  def conversion_form
    ConversionForm::VALIDATION.call(params.permit!.to_h)
  end

  def predictor
    Predictor.new model: Models::RandomAroundCenter.new
  end
end
