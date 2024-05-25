<script setup>
import VueApexCharts from 'vue3-apexcharts'
import { useTheme } from 'vuetify'
import { hexToRgb } from '@layouts/utils'

const vuetifyTheme = useTheme()

const series = [120, 95, 75, 50];  // Update with actual loan data counts



const chartOptions = computed(() => {
  const currentTheme = vuetifyTheme.current.value.colors
  const variableTheme = vuetifyTheme.current.value.variables
  const disabledTextColor = `rgba(${ hexToRgb(String(currentTheme['on-surface'])) },${ variableTheme['disabled-opacity'] })`
  const primaryTextColor = `rgba(${ hexToRgb(String(currentTheme['on-surface'])) },${ variableTheme['high-emphasis-opacity'] })`
  
  return {
    chart: {
      sparkline: { enabled: true },
      animations: { enabled: false },
    },
    stroke: {
      width: 6,
      colors: [currentTheme.surface],
    },
    legend: { show: false },
    tooltip: { enabled: false },
    dataLabels: { enabled: false },
    labels: ['Laptops', 'Projectors', 'Cameras', 'Microphones'],
    colors: [
      currentTheme.success,
      currentTheme.primary,
      currentTheme.secondary,
      currentTheme.info,
    ],
    grid: {
      padding: {
        top: -7,
        bottom: 5,
      },
    },
    states: {
      hover: { filter: { type: 'none' } },
      active: { filter: { type: 'none' } },
    },
    plotOptions: {
      pie: {
        expandOnClick: false,
        donut: {
          size: '75%',
          labels: {
            show: true,
            name: {
              offsetY: 17,
              fontSize: '14px',
              color: disabledTextColor,
              fontFamily: 'Public Sans',
            },
            value: {
              offsetY: -17,
              fontSize: '24px',
              color: primaryTextColor,
              fontFamily: 'Public Sans',
            },
            total: {
              show: true,
              label: 'Weekly',
              fontSize: '14px',
              formatter: () => '38%',
              color: disabledTextColor,
              fontFamily: 'Public Sans',
            },
          },
        },
      },
    },
  }
})

const loans = [
  {
    amount: '120',
    title: 'Laptops',
    avatarColor: 'primary',
    subtitle: 'Most borrowed item',
    avatarIcon: 'bx-laptop',
  },
  {
    amount: '95',
    title: 'Projectors',
    avatarColor: 'success',
    subtitle: 'High demand in presentations',
    avatarRepeatIcon: 'bx-projector',
  },
  {
    amount: '75',
    title: 'Cameras',
    avatarColor: 'info',
    subtitle: 'Popular for media students',
    avatarIcon: 'bx-camera',
  },
  {
    amount: '50',
    title: 'Microphones',
    avatarColor: 'secondary',
    subtitle: 'Essential for digital arts',
    avatarIcon: 'bx-microphone',
  },
]


const moreList = [
  {
    title: 'Share',
    value: 'Share',
  },
  {
    title: 'Refresh',
    value: 'Refresh',
  },
  {
    title: 'Update',
    value: 'Update',
  },
]
</script>

<template>
  <VCard>
    <VCardItem class="pb-3">
      <VCardTitle class="mb-1">
        Most Popular Equipment Loans
      </VCardTitle>


    </VCardItem>

    <VCardText>
      <div class="d-flex align-center justify-space-between mb-3">
        <div class="flex-grow-1">
          <h4 class="text-h4 mb-1">
            {{ totalLoans }} 35
          </h4>
          <span>Total Loans</span>
        </div>

        <div>
          <VueApexCharts
            type="donut"
            :height="125"
            width="105"
            :options="chartOptions"
            :series="series"
          />
        </div>
      </div>

      <VList class="card-list mt-7">
        <VListItem
          v-for="loan in loans"
          :key="loan.title"
        >
          <template #prepend>
            <VAvatar
              rounded
              variant="tonal"
              :color="loan.avatarColor"
            >
              <VIcon :icon="loan.avatarIcon" />
            </VAvatar>
          </template>

          <VListItemTitle class="mb-1">
            {{ loan.title }}
          </VListItemTitle>
          <VListItemSubtitle class="text-disabled">
            {{ loan.subtitle }}
          </VListItemSubtitle>

          <template #append>
            <span>{{ loan.amount }}</span>
          </template>
        </VListItem>
      </VList>
    </VCardText>
  </VCard>
</template>


<style lang="scss" scoped>
.card-list {
  --v-card-list-gap: 21px;
}
</style>
