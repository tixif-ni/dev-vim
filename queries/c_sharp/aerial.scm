(interface_declaration
  name: (identifier) @name
  (#set! "kind" "Interface")
  ) @type

(class_declaration
  (modifier)? @accessModifier
  name: (identifier) @name
  (#set! "kind" "Class")
  ) @type

(struct_declaration
  (modifier)? @accessModifier
  name: (identifier) @name
  (#set! "kind" "Struct")
  ) @type

(method_declaration
  (modifier)? @accessModifier
  name: (identifier) @name
  (#set! "kind" "Method")
  ) @type

(enum_declaration
  name: (identifier) @name
  (#set! "kind" "Enum")
  ) @type

(constructor_declaration
  (modifier)? @accessModifier
  name: (identifier) @name
  (#set! "kind" "Constructor")
  ) @type

(property_declaration
  (modifier)? @accessModifier
  name: (identifier) @name
  (#set! "kind" "Property")
  ) @type

(field_declaration
  (modifier)? @accessModifier
   (variable_declaration
    (variable_declarator
       (identifier) @name))
  (#set! "kind" "Field")
   ) @type
