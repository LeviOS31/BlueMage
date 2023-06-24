extends Control

var buying: Node

func _ready():
	pass # Replace with function body.

func _on_shop_visibility_changed():
	if self.visible == true:
		print("buying")
		for item in get_tree().get_nodes_in_group("items"):
			print("item ", item.name)
			print(item.CostSestertii + item.CostDenarii + item.CostQuinarii)
			if item.shop == true:
				buying = item
				$GoldCost/Cost.text = str(item.CostSestertii)
				$SilverCost/Cost.text = str(item.CostDenarii)
				$BronzeCost/Cost.text = str(item.CostQuinarii)
