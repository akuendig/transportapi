tMap =
  'all': 65535 # 1<<16 - 1
  'ice_tgv_rj': 32768 # 1<<15
  'ec_ic': 16384 # 1<<14
  'ir': 8192 # 1<<13
  're_d': 4096 # 1<<12
  'ship': 2048 # 1<<11
  's_sn_r': 1024 # 1<<10
  'bus': 512 # 1<<9
  'cableway': 256 # 1<<8
  'arz_ext': 128 # 1<<7
  'tramway_underground': 64 # 1<<6

reduce = (list...) ->
  r = (agg, el) -> if tMap[el] then agg |= tMap[el]
  list.reduce r, 0

module.exports.reduce = reduce
