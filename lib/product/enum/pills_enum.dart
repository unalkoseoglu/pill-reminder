enum PillsEnum {
  capsulePill("capsule-pill"),
  tabletsPill("tablets-pill"),
  syrup("syrup"),
  tablet("tablet"),
  antibiotic("antibiotic"),
  spray("spray"),
  injection("injection"),
  thermometer("thermometer");

  final String path;
  const PillsEnum(this.path);

  static List<PillsEnum> pills = [
    PillsEnum.capsulePill,
    PillsEnum.tabletsPill,
    PillsEnum.syrup,
    PillsEnum.tablet,
    PillsEnum.antibiotic,
    PillsEnum.spray,
    PillsEnum.injection,
    PillsEnum.thermometer,
  ];
}
