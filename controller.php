public function getPreviewLoad(){
		$this->load->language('product/product');
		$this->load->model('catalog/product');
		$this->load->model('catalog/review');

		if (isset($this->request->post['product_id']))
		{
			$product_id = $this->request->post['product_id'];

			$products_info = $this->model_catalog_product->getPreviewData($product_id);
			$json = array();
			foreach($products_info->rows as $product_info)
			{
				$json['name']		= $product_info['name'];
				$json['price'] 		= $product_info['price'];
				$json['price']      = $this->currency->format($this->tax->calculate($json['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
				$json['image'] 		= $product_info['image'];
				$json['quantity'] 	= $product_info['quantity'];
				$json['option_id']  = $product_info['option_id'];
				$json['product_id'] = $product_id;
			}

			$json['review'] = array();

			$review_total = $this->model_catalog_review->getTotalReviewsByProductId($product_id);

			$json['review'] = $this->model_catalog_review->getReviewsByProductId($product_id);

			$json['total_review'] = (int)$review_total;

			$json['attribute'] = array();
			$Attr = $this->model_catalog_product->getProductAttributes($product_id);

			foreach($Attr as $attr_group) {
				foreach($attr_group['attribute'] as $attr_groups){
					$json['attribute'][] = array(
						'attribute_name' => $attr_groups['name'],
						'attribute_text' =>$attr_groups['text']
					);
				}
			}


			if(!empty($json['option_id']))
			{
				$json['option'] = array();
				$options_info = $this->model_catalog_product->getPreviewOption($product_id);

				foreach ($options_info->rows as $option_info)
				{
					$json['option'][] = array(
					'option_name' 				=> $option_info['name'],
					'option_quantity'			=> $option_info['quantity'],
					'option_value_id'   		=> $option_info['option_value_id'],
					'product_option_value_id'	=> $option_info['product_option_value_id'],
					'product_option_id'         => $option_info['product_option_id']
					);
				}
			}
			$this->response->addHeader('Content-Type: application/json');
			$this->response->setOutput(json_encode($json));
		}
	}