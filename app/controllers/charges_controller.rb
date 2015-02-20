class ChargesController < ApplicationController
  
 def new
   @stripe_btn_data = {
     key: "#{Rails.configuration.stripe[:publishable_key]}",
     description: "BigMoney Membership - #{current_user.name}",
     #amount: Amount.default
     amount: 15_00
     }
 end

   def create
 
     # Creates a Stripe Customer object, for associating
     # with the charge
     customer = Stripe::Customer.create(
     email: current_user.email,
     card: params[:stripeToken]
     )
 
       #  Where the real magic happens
       charge = Stripe::Charge.create(
         customer: customer.id, # Note -- this is NOT the user_id in your app
         #amount: Amount.default,
         amount: 15_00,
         description: "Premium Membership - #{current_user.email}",
         currency: 'usd'
       )
 
     if flash[:notice] = "Thanks, #{current_user.email}! You are now \"Premium Status\"."
        current_user.update_attributes!(role: 'premium')
        redirect_to wikis_path   # or wherever
      end
       # Stripe will send back CardErrors, with friendly messages
       # when something goes wrong.
       # This `rescue block` catches and displays those errors.
       rescue Stripe::CardError => e
         flash[:error] = e.message
         redirect_to edit_user_registration_path 
       end
  
end

#current_user.update_attributes!(role: 'premium') &&  