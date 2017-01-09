//
// // NOTE: submit a form to create a new service (via ajax)
// function ajaxCreateService(){
//   $('#accounts-admin #new_service').submit(function(event){
//     event.preventDefault();
//
//     // NOTE: Remove form submission error (if any)
//     $('.alert.alert-danger').remove();
//
//     $.ajax({
//       url: this.action,
//       data: $(this).serialize(),
//       dataType: "json",
//       type: this.method,
//
//       success: function(response){
//         // NOTE: check what route submited the form
//         if ( $("#accounts-admin" ).length ) {
//
//           const newService = new Service(response);
//           $("#js-displayServices").append(newService.displayService());
//
//           // NOTE: reset & hide form after successfully submission and change text button back to original state
//           $("#new_service")[0].reset();
//           $("#new_service").hide();
//           $("#js-newServiceBtn").text("Create Service");
//
//         }
//         const html = [
//           '<div class="alert alert-success alert-dismissible fade in" role="alert">',
//           '<button type="button" class="close" data-dismiss="alert" aria-label="Close">',
//           '<span aria-hidden="true">×</span>',
//           '</button>',
//           '<h3 class="text-center">Your service was successfully created!!!</h3>'
//         ].join('');
//
//         // NOTE: print success message
//         $('.js-successMessage').html(html);
//       },
//
//       error: function(errorResponse){
//         const error = $.parseJSON(errorResponse.responseText);
//         const html = [
//           '<div class="alert alert-danger alert-dismissible fade in" role="alert">',
//           '<button type="button" class="close" data-dismiss="alert" aria-label="Close">',
//           '<span aria-hidden="true">×</span>',
//           '</button>',
//           '<div class="flex">',
//           '<h4>Please fix the following errors:</h4>',
//           '<ul class=js-error>',
//         ]
//
//         for (const message in error) {
//           html.push(`<li>${error[message]}</li>`);
//         }
//         html.push(
//                   '</ul>',  //.js-error
//                   '</div>', //.alert
//                   '</div>'  //.flex
//                 );
//
//         // NOTE: place error message above the form
//         $(".formErrors").before(html.join(''));
//       },// end error
//
//       complete: function(){
//
//         // NOTE: enable submit button after preventDefault() and automatically scroll to top of window to view possible errors
//         $('input[type="submit"]').prop('disabled', false);
//         $( "body" ).scrollTop( 0 );
//       }
//
//     });//end ajax()
//
//   });//end submit()
// }
//
//
// // NOTE: Admin request for a list of users(accounts)
// function ajaxGetAccounts(){
//   $("#account-form").submit(function(event) {
//     const selectInput = $('#account_account_id').val();
//
//     event.preventDefault();
//     $('.js-account').html("");
//
//     $.ajax({
//       url: this.action,
//       data: $(this).serialize(),
//       dataType: "json",
//       type: this.method,
//
//       success: function(jsonResponse){
//         if (selectInput === "View All Accounts"){
//           const html = ['<h3 class="text-center">User Accounts</h3>'];
//
//           for (let val of jsonResponse){
//             let account = new Account(val);
//             html.push(account.displayAccount());
//           }
//
//         $('.js-account').append(html);
//
//         } else {
//             const html = ['<h3 class="text-center">User Account</h3>'];
//             const account = new Account(jsonResponse);
//
//             // NOTE: create a list of accounts & orders
//             html.push(account.displayAccount());
//             html.push(account.displayOrder());
//             $('.js-account').append(html);
//         }
//
//       },//end success
//
//       error: function(error){
//
//         // NOTE: create an error message
//         const html = [
//             `<h3>Account belonging to ${selectInput} could not be found</h3>`,
//             '<p>Please check the account and try again.</p>'
//           ].join('');
//           return $('.js-account').append(html);
//       },//end error:
//
//       complete: function(){
//         // NOTE: enable submit button after preventDefault()
//         $('input[type="submit"]').prop('disabled', false);
//
//         // NOTE: add bootstrap class to display a panel
//         $('#js-panel').addClass("panel panel-default")
//       }//end complete:
//
//     });//end ajax()
//   });//end submit()
//
// }//end ajaxGetAccounts(){


// file converted via http://babeljs.io/
'use strict';

// NOTE: submit a form to create a new service (via ajax)
function ajaxCreateService() {
  $('#accounts-admin #new_service').submit(function (event) {
    event.preventDefault();

    // NOTE: Remove form submission error (if any)
    $('.alert.alert-danger').remove();

    $.ajax({
      url: this.action,
      data: $(this).serialize(),
      dataType: "json",
      type: this.method,

      success: function success(response) {
        // NOTE: check what route submited the form
        if ($("#accounts-admin").length) {

          var newService = new Service(response);
          $("#js-displayServices").append(newService.displayService());

          // NOTE: reset & hide form after successfully submission and change text button back to original state
          $("#new_service")[0].reset();
          $("#new_service").hide();
          $("#js-newServiceBtn").text("Create Service");
        }
        var html = ['<div class="alert alert-success alert-dismissible fade in" role="alert">', '<button type="button" class="close" data-dismiss="alert" aria-label="Close">', '<span aria-hidden="true">×</span>', '</button>', '<h3 class="text-center">Your service was successfully created!!!</h3>'].join('');

        // NOTE: print success message
        $('.js-successMessage').html(html);
      },

      error: function error(errorResponse) {
        var error = $.parseJSON(errorResponse.responseText);
        var html = ['<div class="alert alert-danger alert-dismissible fade in" role="alert">', '<button type="button" class="close" data-dismiss="alert" aria-label="Close">', '<span aria-hidden="true">×</span>', '</button>', '<div class="flex">', '<h4>Please fix the following errors:</h4>', '<ul class=js-error>'];

        for (var message in error) {
          html.push('<li>' + error[message] + '</li>');
        }
        html.push('</ul>', //.js-error
        '</div>', //.alert
        '</div>' //.flex
        );

        // NOTE: place error message above the form
        $(".formErrors").before(html.join(''));
      }, // end error

      complete: function complete() {

        // NOTE: enable submit button after preventDefault() and automatically scroll to top of window to view possible errors
        $('input[type="submit"]').prop('disabled', false);
        $("body").scrollTop(0);
      }

    }); //end ajax()
  }); //end submit()
}

// NOTE: Admin request for a list of users(accounts)
function ajaxGetAccounts() {
  $("#account-form").submit(function (event) {
    var selectInput = $('#account_account_id').val();

    event.preventDefault();
    $('.js-account').html("");

    $.ajax({
      url: this.action,
      data: $(this).serialize(),
      dataType: "json",
      type: this.method,

      success: function success(jsonResponse) {
        if (selectInput === "View All Accounts") {
          var html = ['<h3 class="text-center">User Accounts</h3>'];

          var _iteratorNormalCompletion = true;
          var _didIteratorError = false;
          var _iteratorError = undefined;

          try {
            for (var _iterator = jsonResponse[Symbol.iterator](), _step; !(_iteratorNormalCompletion = (_step = _iterator.next()).done); _iteratorNormalCompletion = true) {
              var val = _step.value;

              var account = new Account(val);
              html.push(account.displayAccount());
            }
          } catch (err) {
            _didIteratorError = true;
            _iteratorError = err;
          } finally {
            try {
              if (!_iteratorNormalCompletion && _iterator.return) {
                _iterator.return();
              }
            } finally {
              if (_didIteratorError) {
                throw _iteratorError;
              }
            }
          }

          $('.js-account').append(html);
        } else {
          var _html = ['<h3 class="text-center">User Account</h3>'];
          var _account = new Account(jsonResponse);

          // NOTE: create a list of accounts & orders
          _html.push(_account.displayAccount());
          _html.push(_account.displayOrder());
          $('.js-account').append(_html);
        }
      }, //end success

      error: function error(_error) {

        // NOTE: create an error message
        var html = ['<h3>Account belonging to ' + selectInput + ' could not be found</h3>', '<p>Please check the account and try again.</p>'].join('');
        return $('.js-account').append(html);
      }, //end error:

      complete: function complete() {
        // NOTE: enable submit button after preventDefault()
        $('input[type="submit"]').prop('disabled', false);

        // NOTE: add bootstrap class to display a panel
        $('#js-panel').addClass("panel panel-default");
      } //end complete:

    }); //end ajax()
  }); //end submit()
} //end ajaxGetAccounts(){
