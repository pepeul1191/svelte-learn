<script>
  export let labelHeaders;
  export let data = [];
</script>
  
<table class="table table-striped"> 
  <thead>
    {#each labelHeaders as label}
    <th>{label}</th>
    {/each}
  </thead>
  <tbody>
    {#each data as row}
    <tr>
      <td>{row.code}</td>
      <td>{row.name}</td>
    </tr>
    {/each}
  </tbody>
</table>

<style>
  
</style>