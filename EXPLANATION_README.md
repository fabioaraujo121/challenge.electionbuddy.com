fabioaraujo121@gmail.com

# Explanation

The goal of this solution is to take the easiest way possible to have an historical records on changes related do an Election.

## The models

I opted for a Concern (`Auditable`) that will handle all the complexity inside callbacks.

### `Auditable` Callbacks

These are the before_update and after_create callbacks. The reason for both is because I cannot create an `AuditLog` without and record (`auditable`) ID.
And, Rails provides a method named `changes` that gives me the list of attributes that changed and also its values.

### The data formatting

I chose the approach where I use the own class to format the data and save it in a reusable way. When comes the time to display it again, I simply build the object so we can get all the format we want/need.

### Bypass the current_user

This is a tricky one, the owner of the modification (the modifier, per say) is an logged in user. The Devise instance is not accessible inside the models, so the easiest way at the moment is to merge and attribute (`current_user_id`) to the params during the build.
This `current_user_id` is defined and used inside the `Auditable` concern.

