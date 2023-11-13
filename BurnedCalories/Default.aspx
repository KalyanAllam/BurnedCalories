 

<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Default.aspx.cs"   %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<head>
    <body style="background-color:powderblue;">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
 <title>METS APP</title>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 <script>
     $(document).ready(function () {
         setOption();
         setCateOption();
         $('#CategoryDDL').change(function () {
             setOption();
         });

         $('#Calculate').click(function Calculate() {
             var weigth = 0;
             var weightsel = '';
             var time = 0;
             var perform = 'y';
             var MEts = $('#DescriptionDDL option:selected').val();
             weigth = $('#DropDownList1 option:selected').text() == 'lbs' ? $('#tb_Weight').val() / 2.2 : $('#tb_Weight').val();
             time = $('#DropDownList2 option:selected').text() == 'min' ? $('#tb_time').val() / 60 : $('#tb_time').val();

             if (weigth < 30 || weigth > 200) {
                 alert("Weight out of range !");
                 perform = 'n';
             }

             if (time > 4) {
                 alert("Time out of range !");
                 perform = 'n';
             }

             if (perform == 'y') {
                 $('#result').val(weigth * time * MEts);
             }
         });
     });

     function setOption() {
         $('#DescriptionDDL').html('');
         var DefaultOption = '<option selected  disabled>' + "- Select -" + '</option>';
         $('#DescriptionDDL').append(DefaultOption);
         var Category = $('#CategoryDDL option:selected').text();
         if (Category != '- Select -') {
             $.getJSON('Employees.json', function (data) {
                 for (var act of data.burned.ACTIVITY) {
                     if (act.CATEGORY.toLowerCase() == Category.toLowerCase()) {
                         var str = act.DESC.replace(/\uFFFD/g, '');
                         var option = '<option value=' + act.METS + '>' + str + '</option>';
                         $('#DescriptionDDL').append(option);
                     }
                 }
             });
         }
     }
     function setCateOption() {
         $('#CategoryDDL').html('');
      
         $.getJSON('Employees.json', function (data) {

             const unique = [...new Set(data.burned.ACTIVITY.map(item => item.CATEGORY))];
             var flag = 'n';
             for (var act of unique) {
                 if (flag == 'n') {
                     var option = '<option selected  disabled>' + "- Select -" + '</option>';
                     $('#CategoryDDL').append(option);
                     flag = 'y';
                 }

                 var option = '<option value=' + act + '>' + act + '</option>';
                 $('#CategoryDDL').append(option);

             }
         });
     }
 
 </script>
</head>



<div>
    <h1>Burned Calories</h1>
     <br />
    Weight            : <br /><input name="tb_Weight" type="number"   id="tb_Weight"   /> 
    <select name="DropDownList1" id="DropDownList1">
       <option value="0">kg</option> 
        <option value="1">lbs</option>
    </select>
    <br />
    Activity Time     : <br /><input name="tb_time" type="number" id="tb_time"  />  
    <select name="DropDownList2" id="DropDownList2">
        <option value="0">min</option>
        <option value="1">hr</option>
    </select>
   Activity           :
    <br />
    <select name="CategoryDDL" id="CategoryDDL">
        <option selected="selected" value="- Select -" disabled="">- Select -</option>

    </select>
    <br />
    Description       : <br /><select id="DescriptionDDL"></select>
    <br />
    <button type="button" id="Calculate" value="Calculate">Calculate</button>
    <br />
    Result In Calories: <input name="result" type="text" id="result" readonly/>


</div>
  </body>
</asp:Content>
