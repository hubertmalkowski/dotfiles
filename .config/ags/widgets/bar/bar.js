const battery = await Service.import("battery")
const network = await Service.import("network")
const bluetooth = await Service.import("bluetooth")
const hyprland = await Service.import("hyprland")

const time = Variable("", {
    poll: [1000, 'date "+%H:%M"'],
})

const date = Variable("", {
    poll: [1000, 'date "+%Y-%m-%d"'],
})


function Left() {
    return Widget.Box(
        {
            className: "BarLeftBox",
            spacing: 14,
            children: [
                Widget.Label({
                    className: "BarLabel",
                    label: time.bind()
                }),
                Widget.Label({
                    className: "BarLabel",
                    label: date.bind()
                }),
                Widget.Box({
                    spacing: 3,
                    children: [
                        Widget.Icon({
                            icon: battery.bind('icon_name')
                        }),
                        Widget.Label({
                            label: battery.bind("percent").as((p) => `${p}%`)
                        })
                    ]
                })
            ]
        }
    )
}

function Center() {
    return Widget.Box()
}

function Right() {
    return Widget.Box({
        hpack: 'end',
        spacing: 4,
        children: [
            Widget.Button({
                className: "ActionButton",
                vexpand: false,
                heightRequest: 20,
                vpack: "center",
                child: Widget.Box({
                    heightRequest: 20,
                    spacing: 2,
                    vexpand: false,
                    children: [
                        Widget.Icon({
                            vexpand: false,
                            icon: network.wifi.bind("icon_name")
                        }),

                        Widget.Icon({
                            vexpand: false,
                            icon: bluetooth.bind('enabled').as(on =>
                                `bluetooth-${on ? 'active' : 'disabled'}-symbolic`),
                        }),
                    ]
                })
            }),
            Widget.Button({
                widthRequest: 28,
                heightRequest: 28,
                className: "PrimaryButton",
                child: Widget.Icon("org.gnome.Settings-search-symbolic")
            }),
        ]
    })
}
export function Bar(monitor = 0) {
    return Widget.Window({
        className: "Bar",
        name: `bar-${monitor}`,
        margins: [0, 0, 8, 0],
        monitor: hyprland.bind("monitors").as((m) => {
            let width = 0
            let id = -1
            for (let monitor of m) {
                if (monitor.width > width) {
                    width = monitor.width
                    id = monitor.id
                }
            }
            return id
        }),
        vexpand: true,
        exclusivity: "exclusive",
        width_request: 360,
        anchor: ["bottom"],
        child: Widget.CenterBox({
            className: "BarCenterBox",
            start_widget: Left(),
            center_widget: Center(),
            end_widget: Right()
        })
    })
}
