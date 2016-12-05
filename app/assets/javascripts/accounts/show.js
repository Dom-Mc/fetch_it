"use strict"

$(document).on('turbolinks:load', function() {

  $("#search-form").submit(function(event){

    const searchInput = $('#search').val();
    const orderHistoryPath = "<%= account_orders_path(@user_account) %>";
    const outputHtml = [
          '<div class="alert panel panel-default alert-dismissible">',
          '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>',
          '<div class="flex">'
        ];
    event.preventDefault();

    $.ajax({
      url: this.action,
      data: $(this).serialize(),
      dataType: "json",
      type: this.method,

      success: function(response){
        const urlPath = `/account/${response.account.slug}/orders/${response.id}`;

        outputHtml.push(
              '<ul>',
              `<h2><b>Order #</b>${response.id}</h2>`,
              `<li><b>Pickup Date:</b> ${response.pickup_date}</li>`,
              `<li><b>Shipping Reference:</b> ${response.shipping_reference || ''}</li>`,
              `<li><b>Number of items:</b> ${response.number_of_items}</li>`,
              `<li><b>Shipper's Name:</b> ${response.shipper.first_name || ''} ${response.shipper.last_name}</li>`,
              `<li><b>Recipient's Name:</b> ${response.recipient.first_name} ${response.recipient.last_name}</li>`,
              `<p class="text-center"><a href="${urlPath}" class="btn btn-primary">More info</a><p>`,
              '</ul>'
            );
      },//end success

      error: function(error){
          outputHtml.push(
              `<h3>Order #${searchInput} could not be found</h3>`,
              '<p>Please check your ',
              `<a href="${orderHistoryPath}">order history</a> `,
              'and try again.</p>'
          );
      },

      complete: function(){
        $('#search').val('');
        $('input[type="submit"]').prop('disabled', false);
        outputHtml.push('</div>','</div>');
        $('.js-searchResults').html(outputHtml.join(''));
      }

    });//end ajax()
  });//end submit()

});//end on('turbolinks:load')
