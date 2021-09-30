<script>
  import { onMount, tick } from 'svelte';
  export const date = new Date();
  export const months = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Deciembre'];
  export const days = ['Lun','Mar','Mie','Jue','Vie','Sab','Dom'];
  let calendarDays = [];
  let labelMonth;

  onMount(async () => {
    var month = date.getMonth();
    var year = date.getFullYear();
    date.setDate(1); // go to first day of month
   
    calendarDays = await fillCalendarDays(date, month, year);
    labelMonth = `${months[date.getMonth() - 1]} ${year}`;
  });

  const fillCalendarDays = (date, month, year) => {
    var resp = [];
    var i = 0;
    while(date.getMonth() === month){
      //var t = `${date.getDay()} - ${month} - ${year}`;
      var num = date.getDay();
      var tmp = {};
      var day = date.getDate();
      tmp['day'] = day;
      // date format
      if(day < 10){  
        if(month < 10){
          tmp['date'] = year + '-0' + (month + 1) + '-0' + day;
        }else{
          tmp['date'] = year + '-' + (month + 1) + '-0' + day;
        }
      }else{  
        if(month < 10){
          tmp['date'] = year + '-0' + (month + 1) + '-' + day;
        }else{
          tmp['date'] = year + '-' + (month + 1) + '-' + day;
        }
      }
      // sytles
      tmp['margin'] = ''; 
      //console.log('1 +++++++++++++++++++++++++++++++')
      //console.log('num ' + num)
      //console.log('day ' + day)
      //console.log('2 +++++++++++++++++++++++++++++++')
      if (i == 0) {
        //console.log('IF +++++++++++++++++++++++++++++++')
        if (day === 0) {
          tmp['margin'] = (6 * 14.28) + "%";
        } else {
          tmp['margin'] = ((num - 1) * 14.28) + "%";
        }
        //console.log(tmp)
      }
      i++;
      resp.push(tmp);
      // next day
      date.setDate(date.getDate() + 1);
    }
    console.log(resp)
    return resp;
  };
</script>

<div id="calendarioDemo" class="v-cal">
  <div class="vcal-header">
    <button class="vcal-btn" data-calendar-toggle="previous" id="btnAtras">
      <i class="fa fa-chevron-left" aria-hidden="true"></i>
    </button>
    <div class="vcal-header__label" data-calendar-label="month" id="lblMes">
      {labelMonth}
    </div>
    <button class="vcal-btn" data-calendar-toggle="next" id="btnAdelante">
      <i class="fa fa-chevron-right" aria-hidden="true"></i>
    </button>
  </div>
  <div class="vcal-week">
    {#each days as day}
      <span>{day}</span>
    {/each}
  </div>
  <div class="vcal-body" data-calendar-area="month" id="bodyCadelndario">
    {#each calendarDays as day}
      <div class="vcal-date vcal-date--active" style="margin-left:{day['margin']};" date="{day['date']}">
        <span>{day['day']}</span>
      </div>
    {/each}
  </div>
</div>
<br>
<p class="demo-picked">
  Date picked:
  <span data-calendar-label="picked" id="targetSeleccion"></span>
</p>

<style>
  :root {
    --vcal-bg-color: #fff;
    --vcal-border-radius: 0;
    --vcal-border-color: #e7e9ed;
    --vcal-today-bg-color: #10989E;
    --vcal-today-color: #fff;
    --vcal-selected-bg-color: #E7E9ED;
    --vcal-selected-color: #333;
  }

  .v-cal *, .v-cal *:before, .v-cal *:after {
    box-sizing: border-box;
  }

  .v-cal {
    background-color: var(--vcal-bg-color);
    border-radius: var(--vcal-border-radius);
    border: solid 1px var(--vcal-border-color);
    box-shadow: 0 4px 22px 0 rgba(0, 0, 0, 0.05);
    margin: 0 auto;
    overflow: hidden;
    width: 100%;
  }

  .v-cal .vcal-btn {
    -moz-user-select: none;
    -ms-user-select: none;
    -webkit-appearance: button;
    background: none;
    border: 0;
    color: inherit;
    cursor: pointer;
    font: inherit;
    line-height: normal;
    min-width: 27px;
    outline: none;
    overflow: visible;
    padding: 0;
    text-align: center;
    /*
    &:active {
      border-radius: var(--vcal-border-radius);
      box-shadow: 0 0 0 2px rgba(var(--vcal-today-bg-color), 0.1)
    }
    */
  }

  .v-cal .vcal-header {
    align-items: center;
    display: flex;
    padding: 1.2rem 1.4rem;
  }

  .v-cal .vcal-header svg {
    fill: var(--vcal-today-bg-color);
  }

  .v-cal .vcal-header__label {
    font-weight: bold;
    text-align: center;
    width: 100%;
  }

  .v-cal .vcal-week {
    background-color: var(--vcal-selected-bg-color);
    display: flex;
    flex-wrap: wrap;
  }

  .v-cal .vcal-week span {
    flex-direction: column;
    flex: 0 0 14.28%;
    font-size: 11px;
    font-weight: bold;
    max-width: 14.28%;
    padding: 10px;
    text-align: center;
    text-transform: uppercase;
  }

  .v-cal .vcal-body {
    background-color: rgba(var(--vcal-selected-bg-color), 0.3);
    display: flex;
    flex-wrap: wrap;
  }

  .v-cal .vcal-date {
    align-items: center;
    background-color: #fff;
    border-radius: var(--vcal-border-radius);
    display: flex;
    flex-direction: column;
    flex: 0 0 14.28%;
    max-width: 14.28%;
    padding: 8px;
  }

  .v-cal .vcal-date--active {
    cursor: pointer;
  }

  .v-cal .vcal-date--today {
    background-color: var(--vcal-today-bg-color);
    color: var(--vcal-today-color);
  }

  .v-cal .vcal-date--selected {
    background-color: var(--vcal-selected-bg-color);
    color: var(--vcal-selected-color);
  }

  .v-cal .vcal-date--disabled {
    border-radius: 0;
    cursor: not-allowed;
    opacity: 0.5;
  }
</style>