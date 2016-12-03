class Account {
  constructor(jsonData){
      this.first_name = jsonData.first_name;
      this.last_name = jsonData.last_name;
      this.slug = jsonData.slug;
      this.company = jsonData.company || "";
      this.account_type = jsonData.account_type;
      this.orders = jsonData.orders;
      this.account_number = jsonData.user.account_number;
  }

  displayAccount(){
    const outputHtml = [];
    outputHtml.push(
        '<h4>Account</h4>',
        '<ul>',
        `<li>Account Number: ${this.account_number}</li>`,
        `<li>Account Type: ${this.account_type}</li>`,
        `<li>Company: ${this.company || ''}</li>`,
        `<li>First Name: ${this.first_name}</li>`,
        `<li>Last Name: ${this.last_name}</li>`,
        `<a href="account/${this.slug}">View Profile</a>`,
        '</ul>'
    );
    return outputHtml.join('');
  }//end displayAccount()

  displayOrder(){
    const outputHtml = ['<button data-toggle="collapse" data-target="#js-dropdown-orders">View Orders</button>','<div id="js-dropdown-orders" class="collapse">','<h3>Order History</h3>'];
    for (let order of this.orders){
      outputHtml.push(
          `<h4>Order #${order.id}</h4>`,
          '<ul>',
          `<li>Shipping Reference: ${order.shipping_reference || ""}</li>`,
          `<li>Number of items: ${order.number_of_items}</li>`,
          `<li>Pickup Date: ${order.pickup_date}</li>`,
          `<a href="account/${this.slug}/orders/${order.id}">More info</a>`,
          '</ul>'
      );
    }
    outputHtml.push('</div>');
    return outputHtml.join('');
  }//end displayOrder()
}//end Account


$(document).on('turbolinks:load', function() {

  $("#account-form").submit(function(event){

    const searchInput = $('#account_account_id').val();
    event.preventDefault();
    $('.js-account').html("");

    $.ajax({
      url: this.action,
      data: $(this).serialize(),
      dataType: "json",
      type: this.method,

      success: function(jsonResponse){
        if (searchInput === "View All Accounts"){
          const html = [];

          for (let val of jsonResponse){
            let account = new Account(val);
            html.push(account.displayAccount());
          }

        $('.js-account').append(html);

        } else {
            const html = [];
            const account = new Account(jsonResponse);

            // NOTE: create a list of accounts & orders
            html.push(account.displayAccount());
            html.push(account.displayOrder());
            $('.js-account').append(html);
        }

      },//end success

      error: function(error){

        // NOTE: create an error message
        const html = [
            `<h3>Account belonging to ${searchInput} could not be found</h3>`,
            '<p>Please check the account and try again.</p>'
          ].join('');
          return $('.js-account').append(html);
      },//end error:

      complete: function(){
        // NOTE: enable submit button after preventDefault()
        $('input[type="submit"]').prop('disabled', false);

        // NOTE: add bootstrap class to display a panel
        $('#js-panel').addClass("panel panel-default")
      }//end complete:

    });//end ajax()
  });//end submit()
});//end on('turbolinks:load')
