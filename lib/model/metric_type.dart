enum MetricType {
  CPU_USAGE,
  CPU_TEMP,
  GPU_USAGE,
  GPU_TEMP,
  GPU_VRAM
}

const MetricTypeNames = {
  MetricType.CPU_USAGE: "CPU Usage",
  MetricType.CPU_TEMP: "CPU Temp",
  MetricType.GPU_USAGE: "GPU Usage",
  MetricType.GPU_TEMP: "GPU Temperature",
  MetricType.GPU_VRAM: "GPU VRAM Memory",
};