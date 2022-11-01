# --copyright
# OpenProject is an open source project management software.
# Copyright (C) 2010-2022 the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See COPYRIGHT and LICENSE files for more details.
# ++

require 'spec_helper'

describe ::API::V3::Notifications::DetailsFactory do
  let(:resource) { build_stubbed(:work_package) }

  let(:notification) do
    build_stubbed(:notification,
                  resource:,
                  reason:)
  end

  describe '.for' do
    context 'for a date_alert_start_date notification' do
      let(:reason) { :date_alert_start_date }

      it 'returns one detail' do
        expect(described_class.for(notification).size)
          .to eq 1
      end

      it 'returns an array of `Values::Property` representers' do
        expect(described_class.for(notification)[0])
          .to be_a ::API::V3::Values::PropertyDateRepresenter
      end
    end

    context 'for a date_alert_due_date notification' do
      let(:reason) { :date_alert_due_date }

      it 'returns one detail' do
        expect(described_class.for(notification).size)
          .to eq 1
      end

      it 'returns an array of `Values::Property` representers' do
        expect(described_class.for(notification)[0])
          .to be_a ::API::V3::Values::PropertyDateRepresenter
      end
    end

    (Notification::REASONS.keys - %i[date_alert_start_date date_alert_due_date]).each do |possible_reason|
      context "for a #{possible_reason} notification" do
        let(:reason) { possible_reason }

        it 'is an empty array' do
          expect(described_class.for(notification))
            .to eq []
        end
      end
    end
  end
end