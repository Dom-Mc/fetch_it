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
        '<hr>',
        '<div class="flex">',
        '<ul>',
        `<li><b>Account Number:</b> ${this.account_number}</li>`,
        `<li><b>First Name:</b> ${this.first_name}</li>`,
        `<li><b>Last Name:</b> ${this.last_name}</li>`,
        `<li><b>Account Type:</b> ${this.account_type}</li>`,
        `<li><b>Company:</b> ${this.company || ''}</li>`,
        `<a href="account/${this.slug}">View Profile</a>`,
        '</ul>',
        '</div>'
    );
    return outputHtml.join('');
  }//end displayAccount()

  displayOrder(){
    const outputHtml = [
      '<div class="flex">',
      '<button data-toggle="collapse" data-target="#js-dropdown-orders" class="btn btn-primary ">Display Orders</button>',
      '<div id="js-dropdown-orders" class="collapse">',
      '<hr>',
      '<h3>Order History</h3>'
    ];
    for (let order of this.orders){
      outputHtml.push(
          '<ul>',
          `<li><b>Order #</b>${order.id}</li>`,
          `<li><b>Shipping Reference:</b> ${order.shipping_reference || ""}</li>`,
          `<li><b>Number of items:</b> ${order.number_of_items}</li>`,
          `<li><b>Pickup Date:</b> ${order.pickup_date}</li>`,
          `<p><a href="account/${this.slug}/orders/${order.id}">View Order</a></p>`,
          '</ul>'
      );
    }
    outputHtml.push('</div>','</div>');
    return outputHtml.join('');
  }//end displayOrder()
}//end Account

$(document).on('turbolinks:load', function() {

  $("#account-form").submit(function(event){
    const selectInput = $('#account_account_id').val();

    event.preventDefault();
    $('.js-account').html("");

    $.ajax({
      url: this.action,
      data: $(this).serialize(),
      dataType: "json",
      type: this.method,

      success: function(jsonResponse){
        if (selectInput === "View All Accounts"){
          const html = ['<h3 class="text-center">User Accounts</h3>'];

          for (let val of jsonResponse){
            let account = new Account(val);
            html.push(account.displayAccount());
          }

        $('.js-account').append(html);

        } else {
            const html = ['<h3 class="text-center">User Account</h3>'];
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
            `<h3>Account belonging to ${selectInput} could not be found</h3>`,
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
