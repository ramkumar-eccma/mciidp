<?php
//include "includes/authentication.php";

if (isset($_GET['id'])) { 
$field=$_GET['id'];
#$field='Desc';
/*Insert into material_master from datacl*/
echo $field;
// $datacl_query=mysql_query("Describe datacl");
// while($datacl=mysql_fetch_array($datacl_query))
// {
//      $datacl_list[]=$datacl["Field"];
// }
// $datacl_tot=sizeof($datacl_list);
// $datacl_selectbox="<select id='datcl_sel' class='form-control' onchange='showDetails(this.value)'>";
// for($j=0;$j<$datacl_tot;$j++)
// {
//     $datacl_selectbox=$datacl_selectbox."<option value='".$datacl_list[$j]."'>".$datacl_list[$j]."</option>";
// }
// $datacl_selectbox=$datacl_selectbox."</select>";
}
?>