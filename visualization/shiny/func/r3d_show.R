library(r3dmol)
mol.display  <- function(pdb_file) {
  
r3dmol(
  viewer_spec = m_viewer_spec(
    cartoonQuality = 10, # 图形质量
    lowerZoomLimit = 50, # 缩放下限
    upperZoomLimit = 350 # 缩放上限
  )
) %>%
  m_add_model(data = pdb_file, format = "pdb") %>%  
  # 模型缩放到整体
  m_zoom_to() %>%
  # 设置 Cartoon 样式，并且颜色为红色
  m_set_style(style = m_style_cartoon(color = '#FF3835')) %>% 
  # 设置 beta-折叠为蓝紫色
  m_set_style(sel = m_sel(ss = 's'),                 
              style = m_style_cartoon(color = '#636efa', arrows = TRUE)) %>% 
  # 设置 alpha-螺旋为紫色
  m_set_style(sel = m_sel(ss = 'h'),
              style = m_style_cartoon(color = '#A25FBF')) %>%
  # 初始角度按Y轴旋转90度
  m_rotate(angle = 90, axis = 'y') %>%
  # 旋转动画
  m_spin()
}