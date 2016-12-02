class Account {
  constructor(jsonData){
    this.first_name = jsonData.first_name;
    this.last_name = jsonData.last_name;
    this.slug = jsonData.slug;
    this.company = jsonData.company || "";
    this.account_type = jsonData.account_type;
    this.orders = jsonData.orders;
    // this.account_number = jsonData.account_number;
  }

  outputAccount(){
    let output = [];
    output.push(
      '<h4>Account</h4>',
      '<ul>',
      `<li>Account Type: ${this.account_type}</li>`,
      `<li>Company: ${this.company || ''}</li>`,
      `<li>First Name: ${this.first_name}</li>`,
      `<li>Last Name: ${this.last_name}</li>`,
      `<a href="account/${this.slug}">View Profile</a>`,
      '</ul>'
    );
    return output.join('');
  }//end outputAccount()

  outputOrder(){
    let output = ['<button data-toggle="collapse" data-target="#js-dropdown-orders">View Orders</button>','<div id="js-dropdown-orders" class="collapse">','<h3>Order History</h3>'];
    for (let order of this.orders){
      output.push(
        `<h4>Order #${order.id}</h4>`,
        '<ul>',
        `<li>Shipping Reference: ${order.shipping_reference || ""}</li>`,
        `<li>Number of items: ${order.number_of_items}</li>`,
        `<li>Pickup Date: ${order.pickup_date}</li>`,
        `<a href="account/${this.slug}/orders/${order.id}">More info</a>`,
        '</ul>'
      );
    }
    output.push('</div>');
    return output.join('');
  }//end outputOrder()
}//end Account


$( document ).on('turbolinks:load', function() {

  $("#account-form").submit(function(event){
    event.preventDefault();
    $('.js-account').html("");

    var searchInput = $('#account_account_id').val();
    var output = [
      '<div class="alert panel panel-default alert-dismissible">',
      '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>'
    ];

    $.ajax({
      url: this.action,
      data: $(this).serialize(),
      dataType: "json",
      type: this.method,

      success: function(jsonResponse){
        if (searchInput === "View All Accounts"){
          // var htmlOutput = [];
          let html = [];

          for (let val of jsonResponse){
            let account = new Account(val);
            html.push(account.outputAccount());
          }
          $('.js-account').append(html);

        } else {
            let html = [];
            let account = new Account(jsonResponse);

            html.push(account.outputAccount());
            html.push(account.outputOrder());
            $('.js-account').append(html);
        }

      },//end success
      error: function(error){
        html = [
            `<h3>Account belonging to ${searchInput} could not be found</h3>`,
            '<p>Please check the account and try again.</p>'
          ].join('');
          return $('.js-account').append(html);
      },//end error:
      complete: function(){
        $('input[type="submit"]').prop('disabled', false);
      }//end complete:

    });//end ajax()
  });//end submit()
});//end function() - document ready
