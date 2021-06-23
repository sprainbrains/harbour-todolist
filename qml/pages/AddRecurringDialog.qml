/*
 * This file is part of harbour-todolist.
 *
 * SPDX-FileCopyrightText: 2020 Mirian Margiani
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 *
 * harbour-todolist is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 *
 * harbour-todolist is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <https://www.gnu.org/licenses/>.
 */

import QtQuick 2.2
import Sailfish.Silica 1.0
import "../components"
import "../js/helpers.js" as Helpers

AddItemDialog {
    allowedOrientations: Orientation.All

    property bool enableStartDate: true
    property alias startDate: startDateButton.startDate
    property int intervalDays: intervalCombo.currentItem.value
    property int defaultInterval: 1

    date: new Date(NaN)         // NOTE: redundant? Set already in the parent component?
    descriptionEnabled: true

    IntervalCombo {
        id: intervalCombo
        currentIndex: defaultInterval
    }

    StartDateButton {
        id: startDateButton
        startDate: main.today
        enabled: enableStartDate && intervalCombo.currentIndex !== 0
    }
}
