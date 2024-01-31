local templates = {
    Class = [[
package %s;^
 ^
public class %s {^
 ^
}^
]],
    Interface = [[
package %s;^
 ^
public interface %s {^
 ^
}^
]],
    Enum = [[
package %s;^
 ^
public enum %s {^
 ^
}^
]],
    Record = [[
package %s;^
 ^
public record %s() {^
 ^
}^
]]
}

return templates
