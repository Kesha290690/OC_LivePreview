public function getPreviewData($product_id)
	{
		$query = $this->db->query("SELECT
			  p.image,
			  p.price,
			  p.quantity,
			  p.tax_class_id,
			  c.name,
			  o.option_id
			FROM
			  oc_product p
			  LEFT JOIN oc_product_description c
			  ON p.product_id = c.product_id
			  LEFT JOIN oc_product_option o
			  ON p.product_id = o.product_id
			WHERE p.product_id = '$product_id'");
		return $query;
	}

	public function getPreviewOption($product_id)
	{
		$query = $this->db->query("SELECT DISTINCT
  po.product_option_id,
  pov.option_value_id,
  pov.product_option_value_id,
  pov.quantity,
  pvd.name
FROM oc_product_option po
LEFT JOIN oc_product_option_value pov
ON(
	pov.product_option_id = po.product_option_id
)
LEFT JOIN oc_option_value_description pvd
ON(
	pvd.option_value_id = pov.option_value_id
)
WHERE po.product_id = '$product_id'
ORDER BY pvd.name");

		return $query;
	}