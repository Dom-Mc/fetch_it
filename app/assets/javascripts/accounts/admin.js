// "use strict";

class Account {
  constructor(jsonData){
    this.accountData = jsonData;
  }

  displayAccount(){
    const account = this.accountData;
    const outputHtml = [];
    outputHtml.push(
        '<hr>',
        '<div class="flex">',
        '<ul>',
        `<li><b>Account Number:</b> ${account.account_number}</li>`,
        `<li><b>First Name:</b> ${account.first_name}</li>`,
        `<li><b>Last Name:</b> ${account.last_name}</li>`,
        `<li><b>Account Type:</b> ${account.account_type}</li>`,
        `<li><b>Company:</b> ${account.company || ''}</li>`,
        `<a href="account/${account.slug}">More Info</a>`,
        '</ul>',
        '</div>'
    );
    return outputHtml.join('');
  }//end displayAccount()

  displayOrder(){
    const account = this.accountData;
    const outputHtml = [
      '<div class="flex">',
      '<button data-toggle="collapse" data-target="#js-dropdown-orders" class="btn btn-primary ">Display Orders</button>',
      '<div id="js-dropdown-orders" class="collapse">',
      '<hr>',
      '<h3>Order History</h3>'
    ];
    for (let order of account.orders){
      outputHtml.push(
          '<ul>',
          `<li><b>Order #</b>${order.id}</li>`,
          `<li><b>Shipping Reference:</b> ${order.shipping_reference || ""}</li>`,
          `<li><b>Number of items:</b> ${order.number_of_items}</li>`,
          `<li><b>Pickup Date:</b> ${order.pickup_date}</li>`,
          `<p><a href="account/${account.slug}/orders/${order.id}">More Info</a></p>`,
          '</ul>'
      );
    }
    outputHtml.push('</div>','</div>');
    return outputHtml.join('');

  }//end displayOrder()

}//end Account


class Service {
  constructor(jsonData){
      this.serviceData = jsonData;
  }
  displayService(){
    const service = this.serviceData;
    const outputHtml = [];
    outputHtml.push(
        '<ul class="panel-default">',
        `<h3>${service.service_name}</h3>`,
        `<li><b>Service Name:</b> ${service.service_name}</li>`,
        `<li><b>Description:</b> ${service.description}</li>`,
        `<li><b>Price:</b> ${service.price}</li>`,
        `<li><b>Start Time:</b> ${service.start_time}</li>`,
        `<li><b>End Time:</b> ${service.end_time}</li>`,
        `<a href="service/${service.slug}">More Info</a>`,
        '</ul>'
    );
    return outputHtml.join('');
  }//end displayAccount()

}//end Service


$(document).on('turbolinks:load', function() {

  // NOTE: submits form via ajax
  ajaxCreateService();

  (function(){
    $("#js-serviceBtnGroup").click(function(event){

      event.preventDefault();
      // var htmlPanel = [];

      // NOTE: check witch button from button group was clicked
      if (event.target.id === "js-listServicesBtn"){

        // NOTE: toggles the list of services visibility
        $("#js-displayServices").toggle();

      } else {

        // NOTE: toggles the form's visibility
        $("#new_service").toggle();

        // NOTE: change button text to show & hide form
        changeBtnText();
      }

    });//end click()
  }());//end closure



  (function(){
    const $submitButton = $('#select');

    $submitButton.prop('disabled', true);

    $('#account-form').change(function(){
      if ( $('#account_account_id').val() === "" ) {
        $submitButton.prop('disabled', true);
      } else {
        $submitButton.prop('disabled', false);
      }
    });//end change()

    ajaxGetAccounts();

  }());//end closure

});//end on('turbolinks:load')
