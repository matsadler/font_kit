use std::path::PathBuf;

use magnus::{
    define_module, function, method, DataTypeFunctions, Error, Module, Object, StaticSymbol,
    TypedData,
};

#[derive(DataTypeFunctions, TypedData)]
#[magnus(class = "FontKit::Font", size, free_immediatly)]
struct Font(font_kit::font::Font);

impl Font {
    fn from_path(path: PathBuf, index: u32) -> Result<Self, Error> {
        match font_kit::font::Font::from_path(&path, index) {
            Ok(f) => Ok(Font(f)),
            Err(e) => Err(Error::runtime_error(e.to_string())),
        }
    }

    fn properties(&self) -> Properties {
        Properties(self.0.properties())
    }
}

#[derive(DataTypeFunctions, TypedData)]
#[magnus(class = "FontKit::Properties", size, free_immediatly)]
struct Properties(font_kit::properties::Properties);

impl Properties {
    fn style(&self) -> StaticSymbol {
        use font_kit::properties::Style;

        match self.0.style {
            Style::Normal => StaticSymbol::new("normal"),
            Style::Italic => StaticSymbol::new("italic"),
            Style::Oblique => StaticSymbol::new("oblique"),
        }
    }

    fn weight(&self) -> f32 {
        self.0.weight.0
    }

    fn stretch(&self) -> f32 {
        self.0.stretch.0
    }
}

#[magnus::init]
fn init() -> Result<(), Error> {
    let module = define_module("FontKit")?;

    let font = module.define_class("Font", Default::default())?;
    font.define_singleton_method("from_path", function!(Font::from_path, 2));
    font.define_method("properties", method!(Font::properties, 0));

    let properties = module.define_class("Properties", Default::default())?;
    properties.define_method("style", method!(Properties::style, 0));
    properties.define_method("weight", method!(Properties::weight, 0));
    properties.define_method("stretch", method!(Properties::stretch, 0));

    Ok(())
}
